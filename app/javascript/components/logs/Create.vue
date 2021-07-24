<template>
  <div id="log_modal">
    <div class="log-modal__back" v-if="this.modal" v-on:click.self="toggleModal">
      <div class="log-modal__container">
        <h2>新規ノート作成</h2>
        <form @submit.prevent>
          <div v-if="errors.length" class="error-message__container">
            <ul>
              <li v-for="error in errors" :key="error" class="error-message__text"><i class="fas fa-pen"></i>{{ error }}</li>
            </ul>
          </div>
          <div class="log-input-field">
            <label for="title">タイトル</label>
            <input v-model="log.title" type="text" name="title" class="log-input" id="title">
          </div>
          <div class="log-input-field">
            <label for="error">エラーの内容</label>
            <textarea v-model="log.error" type="text" name="error" class="log-input-field-large" id="error"></textarea>
          </div>
          <div class="log-input-field">
            <label for="solution">解決方法</label>
            <textarea v-model="log.solution" type="text" name="solution" class="log-input-field-large" id="solution"></textarea>
          </div>
          <label for="language" class="label-center mat-30">開発言語</label>
          <div class="log-input-field-lang">
            <template v-for="(item, index) in languages">
              <div class="log-input-field-lang__box" :key="index">
                <input v-model="checkedLanguages" type="checkbox" :value="item.id">
                <label :for="item.name">{{item.name}}</label>
              </div>
            </template>
          </div>
          <label for="release" class="label-center mat-30">公開状態</label>
          <div class="log-input-field-small">
            <input v-model="log.release" type="radio" name="release" value="true" class="log-input-radio" id="release">
            <label for="release">公開</label>
            <input v-model="log.release" type="radio" name="release" value="false" class="log-input-radio" id="release">
            <label for="release">非公開</label>
          </div>
          <div class="inner-bottom-btn-wrap">
            <button v-on:click="createNote" type="submit" class="btn-default">
              <i class="fas fa-upload"></i> 保存する
            </button>
          </div>
        </form>
      </div>
      <div class="log-modal__opener">
        <i v-on:click="toggleModal" class="fas fa-times fa-lg"></i>
      </div>
    </div>
    <div class="log-modal__opener" v-else>
      <i v-on:click="toggleModal" class="fas fa-pen fa-lg"></i>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

export default {
  data() {
    return {
      modal: false,
      languages: [],
      log: {
        title: '',
        error: '',
        solution: '',
        release: true,
      },
      checkedLanguages: [],
      log_info: {
        id: 0,
        user_id: 0,
      },
      errors: [],
    }
  },
  props: {
    logSignal: false,
  },
  watch: {
    logSignal: function(){
      if(this.logSignal){
        this.toggleModal();
        this.$emit("closeLogSignal");
      }
    } 
  },
  mounted() {
    var self = this;
    axios
      .get('/api/v1/languages/index.json')
      .then(response => (self.languages = response.data))
  },
  methods: {
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
    beforCreate: function(e){
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
    createLog: async function(){
      await axios
        .post('/api/v1/logs/create.json', {
          log: {
            title: this.log.title,
            error: this.log.error,
            solution: this.log.solution,
            release: this.log.release,
            language_ids: this.checkedLanguages
          }
        })
        .then(response => {
          this.log_info = response.data
        })
        .catch(error => {
          console.log('error:', error)
        })
    },
    createNote: async function(){
      var self = this;
      await this.beforCreate();
      await this.createLog();
      await this.afterCreate();
    },
    afterCreate: async function(){
      var self = this;
      location.href="/users/"+self.log_info.user_id+"/logs/"+self.log_info.id;
    }
  }
}
</script>
<style scoped>

</style>
