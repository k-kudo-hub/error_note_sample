<template>
  <div id="log-modal">
    <div class="log-modal__back" v-if="this.modal == true" v-on:click.self="toggleModal">
      <div class="log-modal__container">
        <h2>新規ノート作成</h2>
        <form>
          <div class="log-input-field">
            <label for="title">タイトル</label>
            <input type="text" name="title" class="log-input" id="title">
          </div>
          <div class="log-input-field">
            <label for="error">エラーの内容</label>
            <textarea type="text" name="error" class="log-input-field-large" id="error"></textarea>
          </div>
          <div class="log-input-field">
            <label for="solution">解決方法</label>
            <textarea type="text" name="solution" class="log-input-field-large" id="solution"></textarea>
          </div>
          <label for="language" class="label-center mat-30">開発言語</label>
          <div class="log-input-field-lang">
            <template v-for="(item, index) in languages">
              <div class="log-input-field-lang__box" :key="index">
                <input type="checkbox" :value="item.id">
                <label :for="item.name">{{item.name}}</label>
              </div>
            </template>
          </div>
          <label for="release" class="label-center mat-30">公開状態</label>
          <div class="log-input-field-small">
            <input type="radio" name="release" value="true" class="log-input-radio" id="release">
            <label for="release">公開</label>
            <input type="radio" name="release" value="false" class="log-input-radio" id="release">
            <label for="release">非公開</label>
          </div>
          <div class="inner-bottom-btn-wrap">
            <input type="submit" name="commit" value="保存する" class="btn-default" data-disable-with="保存する">
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

export default {
  data() {
    return {
      // modal: false,
      modal: true,
      languages: [],
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
      this.modal == true ? this.modal = false : this.modal = true;
    },
  },
}
</script>
<style scoped>
.inner-bottom-btn-wrap {
  margin-top: 20px;
  text-align: center;
}
.log-modal__back {
  background-color: rgba(0,0,0, 0.4);
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 5;
}
.log-modal__container {
  background-color: white;
  padding: 32px;
  max-width: 700px;
  margin: 50px auto 30px;
  z-index: 6;
}
.log-modal__container h2 {
  text-align: center;
}
.log-modal__opener {
  height: 50px;
  width: 50px;
  position: fixed;
  right: 5%;
  bottom: 5%;
  z-index: 2;
  background-color: #509556;
  border-radius: 40px;
}
.log-modal__opener i {
  height: 20px;
  width: 20px;
  color: white;
  position: absolute;
  top: 35%;
  left: 32%;
}
</style>
