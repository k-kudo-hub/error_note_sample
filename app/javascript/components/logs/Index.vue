<template>
  <div class="top-flex">
    <section class="mobile__search-bar" v-if="this.currentUser.auth">
      <form @submit.prevent @keypress.prevent.enter.exact="getSearchLogs" class="search-form">
        <span class="fa-stack">
          <input v-model="keyword" placeholder="キーワードを入力" class="fa-lg fa-stack-2x">
          <i class="fas fa-search fa-lg fa-stack-1x"></i>
        </span>
        <input type="hidden" value="検索">
      </form>
    </section>
    <nav class="nav-side-bar">
      <div class="nav-side-bar__navigation">
        <div class="navigation__link-wrap">
          <i class="far fa-clock"></i>
          <button class="nav-link" @click="this.getLatestLogs">新着ノート</button>
        </div>
        <div class="navigation__link-wrap">
          <i class="fas fa-fire-alt"></i>
          <button class="nav-link" @click="this.getMostStockedLogs">話題のノート</button>
        </div>
        <template v-if="this.currentUser.auth">
          <div class="navigation__link-wrap">
            <i class="fas fa-cubes"></i>
            <button class="nav-link" @click="this.getLatestStocks">ストックしたノート</button>
          </div>
        </template>
      </div>
    </nav>
    <LogsTable
      :logs="logs"
      :currentUser="currentUser"
      :currentPage="currentPage"
      :totalPages="totalPages"
      :currentLogs="getLatestLogs"
      :pageTitle="pageTitle"
      :addClass="'inner-narrow'"
      @paginate="paginateLog"
      @showMoreInfo="showMoreInformations"
      @showMoreUserInfo="showMoreUserInformations"
    />
    <aside class="nav-side-bar">
      <UserRank/>
      <NotificationsIndex
        @openNoticeDetail="openNoticeDetail"
      />
    </aside>
  </div>
</template>

<script>
import axios from 'axios';
import Vuetify from 'vuetify';
import UserRank from 'components/users/Rank.vue';
import LogsTable from 'components/logs/Table.vue';
import NotificationsIndex from 'components/notifications/Index.vue'
export default {
  components: {
    UserRank,
    LogsTable,
    NotificationsIndex,
  },
  data(){
    return{
      logs: {
        id: 0,
        title: "",
        languages: [],
        updated_at: "",
        release: true,
        user_id: 0,
        user_name: "",
        user_picture: "",
      },
      currentPage: 1,
      itemPerPage: 20,
      totalPages: null,
      pageTitle: "新着ノート",
      currentLogs: this.getLatestLogs,
      keyword: null,
      notification_id: null,
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
  watch: {
    catchKeyword(){
      this.keyword = this.$props.catchKeyword;
      this.getSearchLogs();
    }
  },
  methods: {
    getLatestLogs(){
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
    getMostStockedLogs(){
      if (this.currentLogs != this.getMostStockedLogs){
        this.currentPage = 1;
        this.currentLogs = this.getMostStockedLogs;
        this.pageTitle = "話題のノート";
      }
      axios
        .get(`/api/v1/logs/most_stocked_index.json?per=${this.itemPerPage}`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.totalPages
        ))
    },
    getLatestStocks(){
      if (this.currentLogs != this.getLatestStocks){
        this.currentPage = 1;
        this.currentLogs = this.getLatestStocks;
        this.pageTitle = "ストックしたノート"
      }
      axios
        .get(`/api/v1/logs/latest_stocks_index.json?page=${this.currentPage}&per=${this.itemPerPage}`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.totalPages
        ))
    },
    getSearchLogs(){
      if (this.currentLogs != this.getSearchLogs){
        this.currentPage = 1;
        this.currentLogs = this.getSearchLogs;
        this.pageTitle = "検索結果"
      }
      axios
        .get(`/api/v1/logs/search.json?keyword=${this.keyword}&page=${this.currentPage}&per=${this.itemPerPage}&user_id=${this.currentUser.id}`)
        .then(response => (
          this.logs = response.data.logs,
          this.totalPages = response.data.total_pages
        ))
    },
    trimName(langName){
      var name = langName.toLowerCase().replace(/\s+/g, '').replace('#', 's').replace('.', 'd').replace('++', 'pp');
      return name;
    },
    showMoreInformations(user_id, log_id){
      this.$router.push({
        name: 'logs-show',
        params: {
          user_id: user_id,
          log_id: log_id, 
        }
      })
    },
    showMoreUserInformations(user_id){
      this.$router.push({
        name: 'users-show',
        params: {
          user_id: user_id
        }
      })
    },
    paginateLog(...args){
      this.currentPage = args[0]
      this.currentLogs();
    },
    openNoticeDetail(...args){
      this.notification_id = args[0]
      console.log(args[0])
      this.$emit("openNoticeDetail", this.notification_id)
    }
  },
}
</script>
<style lang="scss" scoped>
.log-block__upper h2,
.nav-link:hover {
  cursor: pointer;
}
</style>
