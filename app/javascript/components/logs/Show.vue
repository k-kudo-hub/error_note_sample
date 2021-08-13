<template>
  <div id="log-details">
    <LogsUpdate 
      v-if="currentUser.auth && (currentUser.id == user.id) && modal" 
      :log="log"
      :checkedLanguages="checkedLanguages"
      :modal="modal"
      :errors="errors"
      @toggle="toggleModal"
      @submit="updateNote"
      @change="changeCheckedLanguages"
    />
    <LogsDestroy
      v-if="currentUser.auth && (currentUser.id == user.id) && confirmModal" 
      :title="log.title"
      @submit="destroyNote"
      @cancel="toggleConfirmModal"
    />
    <section class="app-body-inner">
      <div class="log-detail">
        <h1 class="page-title">{{ log.title }}</h1>
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
          <p class="log-detail__content-error">{{ log.error }}</p>
        </div>
        <div class="log-detail__content solutions">
          <p class="log-detail__content-title">解決法</p>
            <p v-if="log.solution" class="log-detail__content-solution">{{log.solution}}</p>
            <p v-else class="log-detail__content-nil">解決法はまだ登録されていません。</p>
        </div>
      </div>
      <div class="inner-bottom-btn-wrap">
        <template v-if="currentUser.auth">
          <template v-if="currentUser.id == user.id">
            <a @click="toggleModal" class="btn-default"><i class="fas fa-edit"></i> 編集する</a>
            <a @click="toggleConfirmModal" class="btn-danger"><i class="fas fa-trash-alt"></i> 削除する</a>
          </template>
          <template v-else>
            <template v-if="alreadyStocked">
              <button class="btn-filled" @click="destroyStock">
                <p>ストックを取り消す <span class="stock-count__number">{{ stockedCount }}</span></p>
              </button>
            </template>
            <template v-else>
              <button class="btn-default" @click="createStock">
                <p>ストックする <span class="stock-count__number">{{ stockedCount }}</span></p>
              </button>
            </template>
          </template>
        </template>
        <template v-else>
          <button class="btn-default" @click="createStock">
            <p>ストックする <span class="stock-count__number">{{ stockedCount }}</span></p>
          </button>
        </template>
      </div>
    </section>
    <UsersProfile :user="user" :currentUser="currentUser" use_case="log" />
  </div>
</template>

<script>
import axios from 'axios';
import UsersProfile from 'components/users/Profile';
import LogsUpdate from 'components/logs/Update';
import LogsDestroy from 'components/logs/Destroy';

const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

export default {
  components: {
    'UsersProfile': UsersProfile,
    'LogsUpdate': LogsUpdate,
    'LogsDestroy': LogsDestroy,
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
        {
         id: 0, 
         name: ""
        },
      ],
      alreadyStocked: false,
      checkedLanguages: [],
      errors: [],
      modal: false,
      confirmModal: false,
      stockedCount: 0,
      newCheckedLanguages: [],
      newLog: [],
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
          this.languages = response.data.languages,
          this.getLanguageIds(response.data.languages)
        ))
        .catch(error => {
          this.onError();
        })
    },
    trimName: function(langName){
      var name = langName.toLowerCase().replace(/\s+/g, '').replace('#', 's').replace('.', 'd').replace('++', 'pp');
      return name;
    },
    getStockData: async function(){
      await axios
        .get(`/api/v1/stocks/check.json?log_id=${this.$route.params['log_id']}`)
        .then(response => (
          this.alreadyStocked = response.data.stocked,
          this.stockedCount = response.data.count
        ))
    },
    toggleModal: function(){
      const targetSelector = document.getElementsByTagName('html')[0];
      if(this.modal){
        this.modal = false;
        targetSelector.classList.remove("scroll-lock");
      } else {
        this.modal = true;
        targetSelector.classList.add("scroll-lock");
      }
    },
    toggleConfirmModal: function(){
      const targetSelector = document.getElementsByTagName('html')[0];
      if(this.confirmModal){
        this.confirmModal = false;
        targetSelector.classList.remove("scroll-lock");
      } else {
        this.confirmModal = true;
        targetSelector.classList.add("scroll-lock");
      }
    },
    getLanguageIds: function(languages){
      for(var language in languages) {
        this.checkedLanguages.push(languages[language].id)
      }
    },
    changeCheckedLanguages(...args){
      this.newCheckedLanguages = args
    },
    beforUpdate: function(e){
      this.errors = [];
      if (this.log.title && this.log.error) {
        return true;
      }
      if (!this.log.title){
        this.errors.push('タイトルを入力してください');
      }
      if (!this.log.error){
        this.errors.push('エラーの内容を入力してください');
      };
      e.preventDefault();
    },
    updateLog: async function(log, languages){
      await axios
        .put(`/api/v1/logs/update.json?id=${this.log.id}`, {log: log, languages: languages})
        .then(response => {
          console.log(response.data)
          this.log_info = response.data
        })
        .catch(error => {
          console.log('error:', error)
        })
    },
    afterUpdate: function(){
      var self = this;
      location.href="/users/"+self.log_info.user_id+"/logs/"+self.log_info.id;
    },
    updateNote: async function(...args){
      await this.beforUpdate();
      await this.updateLog(args[0], this.newCheckedLanguages[0]);
      await this.afterUpdate();
    },
    destroyNote: function(){
      axios
        .delete(`/api/v1/logs/destroy.json?id=${this.log.id}`)
        .then(response => {
          console.log(response.data)
          location.href=`/users/${response.data}`;
        })
        .catch(error => {
          console.log('error:', error)
        })
    },
    createStock: function(){
      if(this.currentUser.auth){
        axios
          .post(`/api/v1/stocks/create.json?log_id=${this.log.id}`)
          .then(response => {
            console.log(response.data)
          })
        this.alreadyStocked = true;
        this.stockedCount += 1;
      } else {
        location.href='/users/sign_in';
      }
    },
    destroyStock: function(){
      axios
        .delete(`/api/v1/stocks/destroy.json?log_id=${this.log.id}`)
        .then(response => {
          console.log(response.data)
        })
      this.alreadyStocked = false;
      this.stockedCount -= 1;
    },
    onError: function(){
      location.href='/not_found';
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
