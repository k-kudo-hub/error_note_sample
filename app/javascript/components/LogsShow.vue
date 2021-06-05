<template>
  <div id="log-details">
    <LogsUpdate 
      v-if="(currentUser.auth == true) && (currentUser.id == user.id) && (modal == true)" 
      :log="log"
      :checkedLanguages="checkedLanguages"
      :modal="modal"
      :errors="errors"
      @toggle="toggleModal"
      @submit="updateNote"
      @change="changeCheckedLanguages"
    />
    <section class="app-body-inner">
      <div class="log-detail">
        <h1>{{ log.title }}</h1>
        <div class="log-detail__langs">
          <template v-for="language in languages">
            <p class="lang" :class="trimName(language.name)" :key="language.name">{{ language.name }}</p>
          </template>
        </div>
        <div class="log-updated-at">
          <p>最終更新日：{{ log.updated_at }}</p>
        </div>
        <div class="log-detail__content errors">
          <p class="log-detail__content-title">エラーの内容</p>
          {{ log.error }}
        </div>
        <div class="log-detail__content solutions">
          <p class="log-detail__content-title">解決法</p>
            <p v-if="log.solution">{{log.solution}}</p>
            <p v-else class="log-detail__content-nil">解決法はまだ登録されていません。</p>
        </div>
      </div>
      <div class="inner-bottom-btn-wrap">
        <template v-if="currentUser.auth == true">
          <template v-if="currentUser.id == user.id">
            <a class="btn-default">ログを編集する</a>
            <a class="btn-danger">ログを削除する</a>
          </template>
          <template v-else>
            <template v-if="alreadyStocked == true">
              <button class="btn-filled"> <!-- ここにストックアクションを追加 -->
                <p>ストックを取り消す <span class="stock-count__number">{{ stockedCount }}</span></p>
              </button>
            </template>
            <template v-else>
              <button class="btn-default"> <!-- ここにストックアクションを追加 -->
                <p>ストックする <span class="stock-count__number">{{ stockedCount }}</span></p>
              </button>
            </template>
          </template>
        </template>
        <template v-else>
          <button class="btn-default"> <!-- ここにストックアクションを追加 -->
            <p>ストックする <span class="stock-count__number">{{ stockedCount }}</span></p>
          </button>
        </template>
      </div>
    </section>
    <UsersProfile :user="user" :currentUser="currentUser" use_case="log"></UsersProfile>
  </div>
</template>

<script>
import axios from 'axios';
import UsersProfile from './UsersProfile';

export default {
  components: {
    'UsersProfile': UsersProfile,
  },
  data(){
    return {
      log: {
        id: 0,
        user_id: 0,
        title: "",
        error: "",
        solution: "",
        release: false,
      },
      user: {
        id: 0,
        name: "",
        picture: "",
        introduce: "",
      },
      languages: [
        {name: ""},
      ],
      stockedCount: 0,
      alreadyStocked: false,
    }
  },
  props: {
    currentUser: {
      id: null,
      picture: null,
      auth: false,
    },
  },
  mounted(){
    this.getLogDetail();
    this.getStockData();
  },
  methods: {
    getLogDetail: async function(){
      await axios
        .get(`/api/v1/logs/show.json?user_id=${this.$route.params['user_id']}&id=${this.$route.params['log_id']}`)
        .then(response => (
          this.log = response.data.log,
          this.user = response.data.user,
          this.languages = response.data.languages
        ))
    },
    trimName: function(langName){
      var name = langName.toLowerCase().replace(/\s+/g, '').replace('#', 's').replace('.', 'd');
      return name;
    },
    getStockData: async function(current_user_id, log_id){
      await axios
        .get(`/api/v1/stocks/check.json?user_id=${this.currentUser.id}&log_id=${this.$route.params['log_id']}`)
        .then(response => (
          this.alreadyStocked = response.data.stocked,
          this.stockedCount = response.data.count
        ))
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
