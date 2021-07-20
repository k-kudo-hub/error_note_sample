<template>
  <div id="log_modal">
    <div class="log-modal__back" @click.self="$emit('toggle')">
      <div class="log-modal__container">
        <h2>ノート編集</h2>
        <form @submit.prevent>
          <div v-if="errors.length" class="error-message__container">
            <ul>
              <li v-for="error in errors" :key="error" class="error-message__text"><i class="fas fa-pen"></i>{{ error }}</li>
            </ul>
          </div>
          <div class="log-input-field">
            <label for="title">タイトル</label>
            <input v-model="localLog.title" type="text" name="title" class="log-input" id="title">
          </div>
          <div class="log-input-field">
            <label for="error">エラーの内容</label>
            <textarea v-model="localLog.error" type="text" name="error" class="log-input-field-large" id="error"></textarea>
          </div>
          <div class="log-input-field">
            <label for="solution">解決方法</label>
            <textarea v-model="localLog.solution" type="text" name="solution" class="log-input-field-large" id="solution"></textarea>
          </div>
          <label for="language" class="label-center mat-30">開発言語</label>
          <div class="log-input-field-lang">
            <template v-for="(item, index) in languages">
              <div class="log-input-field-lang__box" :key="index">
                <input :checked="checkedLanguages.includes(item.id)" @change="updateCheckedLanguages(item.id)" type="checkbox">
                <label :for="item.name">{{item.name}}</label>
              </div>
            </template>
          </div>
          <label for="release" class="label-center mat-30">公開状態</label>
          <div class="log-input-field-small">
            <input v-model="localLog.release" type="radio" name="release" value="true" class="log-input-radio" id="release">
            <label for="release">公開</label>
            <input v-model="localLog.release" type="radio" name="release" value="false" class="log-input-radio" id="release">
            <label for="release">非公開</label>
          </div>
          <div class="inner-bottom-btn-wrap">
            <button @click="$emit('toggle')" type="submit" class="btn-default">
              <i class="fas fa-long-arrow-alt-left"></i> キャンセル
            </button>
            <button @click="$emit('submit', log)" type="submit" class="btn-filled">
              <i class="fas fa-upload"></i> 更新する
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';

export default {
  data() {
    return {
      languages: [],
      newLanguages: [],
    }
  },
  props: {
    errors: {type: Array},
    modal: {type: Boolean},
    log: {
      id: {type: Number},
      title: {type: String},
      error: {type: String},
      solution: {type: String},
      release: {type: Number},
    },
    checkedLanguages: {
      type: Array,
    },
  },
  computed: {
    localLog: {
      get: function(){
        return this.log
      },
      set: function(value) {
        this.$emit('submit', value)
      },
    },
  },
  mounted() {
    var self = this;
    axios
      .get('/api/v1/languages/index.json')
      .then(response => (self.languages = response.data))
    this.setCheckedLanguages();
  },
  methods: {
    setCheckedLanguages: function(){
      for(var lang in this.checkedLanguages){
        this.newLanguages.push(this.checkedLanguages[lang])
      }
      this.$emit('change', this.newLanguages)
    },
    updateCheckedLanguages: function(languageId) {
      if(this.newLanguages.includes(languageId)){
        this.newLanguages = this.newLanguages.filter(n => n !== languageId);
      } else {
        this.newLanguages.push(languageId)
      }
      this.$emit('change', this.newLanguages)
    },
  },
}
</script>
<style lang="scss" scoped>

</style>
