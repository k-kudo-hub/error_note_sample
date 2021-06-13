<template>
  <div class="top-flex">
    <section class="nav-bar">
      <div class="nav-bar__navigation">
        <div class="navigation__link-wrap">
          <i class="far fa-clock"></i>
          <a class="nav-link" @click="this.getLatestLogs">新着ノート</a>
        </div>
        <div class="navigation__link-wrap">
          <i class="fas fa-fire-alt"></i>
          <a class="nav-link" @click="this.getMostStockedLogs">話題のノート</a>
        </div>
        <template v-if="this.currentUser.auth == true">
          <div class="navigation__link-wrap">
            <i class="fas fa-cubes"></i>
            <a class="nav-link" @click="this.getLatestStocks">最近ストックしたノート</a>
          </div>
        </template>
      </div>
    </section>
    <section class="app-body-inner inner-narrow">
      <h1>{{pageTitle}}</h1>
      <v-list three-line>
        <article v-for="(item) in logs" :key="item.id" class="log-block" :items-per-page="itemPerPage">
          <div class="log-block__upper">
            <h2 @click="showMoreInfomations(item.user_id, item.id)">{{item.title}}</h2>
          </div>
          <div class="log-block__lower">
            <div class="log-block__lower-languages">
              <template v-for="language in item.languages">
                <a class="lang" :class="trimName(language)" :key="language.name">{{ language }}</a>
              </template>
            </div>
            <div class="log-block__lower-user">
              <template v-if="item.user_picture">  
                <img :src="item.user_picture" height="25px" width="25px">
              </template>
              <template v-else>
                <img src="../../assets/images/human.png" height="25px" width="25px">
              </template>
              <div class="log-block__text-container">
                <template v-if="item.release == true">
                  <p class="mr-5"><a @click="showMoreUserInfomations(item.user_id)">{{item.user_name}}</a></p>
                  <p>が{{item.updated_at}}に公開</p>
                </template>
                <template v-else>  
                  <p> 非公開（{{item.updated_at}}作成）</p>
                </template>
              </div>
            </div>
          </div>
        </article>
        <template v-if="this.totalPages > 1">
          <v-pagination
            v-model="currentPage"
            :length="totalPages"
            :total-visible="7"
            @input="currentLogs"
            color="#80c683"
            prev-icon="mdi-menu-left"
            next-icon="mdi-menu-right"
            circle
          />
        </template>
      </v-list>
      <p class="no-content-message" v-if="this.logs.length == 0">{{pageTitle}}はありません。</p>
    </section>
    <section class="nav-bar">
      <div class="nav-bar__usage" id="nav_bar_usage">
        <iframe width="300"
                height="200"
                src="https://www.youtube-nocookie.com/embed/4dnT-kKIO6Y" 
                title="YouTube video player" 
                frameborder="0" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                allowfullscreen>
        </iframe>
      </div>
      <div class="nav-bar__lang-rank" id="nav_bar_lang_rank">
        <UserRank></UserRank>
      </div>
    </section>
  </div>
</template>

<script>
import axios from 'axios';
import Vuetify from 'vuetify';
import UserRank from 'components/UserRank.vue';

export default {
  components: {
    'UserRank': UserRank,
  },
  data(){
    return{
      logs: [
        {
          id: 0,
          title: "",
          languages: [],
          updated_at: "",
          release: true,
          user_id: 0,
          user_name: "",
          user_picture: "",
        }
      ],
      currentPage: 1,
      itemPerPage: 10,
      totalPages: null,
      pageTitle: "新着ノート",
      currentLogs: this.getLatestLogs,
      keyword: null,
    }
  },
  props: {
    currentUser: {
      id: null,
      picture: null,
      auth: false,
    },
    catchKeyword: "",
  },
  mounted(){
    this.getLatestLogs();
  },
  methods: {
    getLatestLogs: function(){
      if (this.currentLogs != this.getLatestLogs){
        this.currentPage = 1;
        this.currentLogs = this.getLatestLogs;
        this.pageTitle = "新着ノート";
      }
      axios
        .get(`/api/v1/logs/index.json?page=${this.currentPage}&per=${this.itemPerPage}`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.total_pages
        ))
      this.currentLogs = this.getLatestLogs;
    },
    getMostStockedLogs: function(){
      if (this.currentLogs != this.getMostStockedLogs){
        this.currentPage = 1;
        this.currentLogs = this.getMostStockedLogs;
        this.pageTitle = "話題のノート";
      }
      axios
        .get(`/api/v1/logs/most_stocked_logs.json`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.totalPages
        ))
    },
    getLatestStocks: function(){
      if (this.currentLogs != this.getLatestStocks){
        this.currentPage = 1;
        this.currentLogs = this.getLatestStocks;
        this.pageTitle = "最近ストックしたノート"
      }  
      axios
        .get(`/api/v1/logs/latest_stocks.json?page=${this.currentPage}&per=${this.itemPerPage}`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.totalPages
        ))
    },
    getSearchLogs: function(){
      if (this.currentLogs != this.getSearchLogs){
        this.currentPage = 1;
        this.currentLogs = this.getSearchLogs;
        this.pageTitle = "検索結果"
      }
      axios
        .get(`/api/v1/logs/search.json?keyword=${this.keyword}&page=${this.currentPage}&per=${this.itemPerPage}&user_id=${this.currentUser.id}`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.total_page 
        ))
    },
    trimName: function(langName){
      var name = langName.toLowerCase().replace(/\s+/g, '').replace('#', 's').replace('.', 'd');
      return name;
    },
    showMoreInfomations: function(user_id, log_id){
      this.$router.push({
        name: 'logs-show',
        params: {
          user_id: user_id,
          log_id: log_id, 
        }
      })
    },
    showMoreUserInfomations: function(user_id){
      this.$router.push({
        name: 'users-show',
        params: {
          user_id: user_id
        }
      })
    }
  },
  watch: {
    catchKeyword: function(){
      this.keyword = this.$props.catchKeyword;
      this.getSearchLogs();
    }
  }
}
</script>
<style lang="scss" scoped>
.log-block__upper h2,
.nav-link:hover {
  cursor: pointer;
}
</style>
