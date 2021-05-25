<template>
  <div id="rank_content">
    <template v-if="this.toggle == true">
      <h2>開発言語ランキング<i v-on:click="toggleBtn" class="fas fa-random fa-lg"></i></h2>
      <p class="lang-rank__date">{{ date }} 現在</p>
      <div class="lang-rank__box" v-for="(item, index) in languages" :key="item.id">
        <div class="lang-rank__box-left">
          <p class="lang-rank__index">{{ index + 1 }}</p>
          <a class="lang" v-bind:class="trimName(item.name)">{{ item.name }}</a>
        </div>
        <div class="lang-rank__box-right">
          <p class="lang-rank__count">{{item.count}} Notes</p>
        </div>
      </div>
    </template>
    <template v-else>
      <h2>ストックランキング<i v-on:click="toggleBtn" class="fas fa-random fa-lg"></i></h2>
      <p class="lang-rank__date">{{ date }} 現在</p>
      <div class="lang-rank__box-container">
        <div class="lang-rank__box" v-for="(item, index) in logs" :key="item.id">
          <div class="lang-rank__box-left">
            <p class="lang-rank__index">{{ index + 1 }}</p>
            <a :href="'/users/'+item.user_id+'/logs/'+item.id" class="rank__stock-title">{{ item.title }}</a>
          </div>
          <div class="lang-rank__box-right">
            <p class="lang-rank__count">{{item.count}} Stocks</p>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      toggle: true,
      date: '',
      languages: [],
      logs: [],
    }
  },
  created(){
    window.onload = this.setToday();
  },
  mounted(){
    var self = this;
    axios
      .get('/api/v1/logs/lang_count.json')
      .then(response => (self.languages = response.data))
    axios
      .get('/api/v1/logs/stock_count.json')
      .then(response => (self.logs = response.data))
  },
  methods:{
    toggleBtn: function(){
      this.toggle == true ? this.toggle = false : this.toggle = true;
    },
    setToday: function(){
      var today = new Date();
      var year = today.getFullYear();
      var month = today.getMonth() + 1;
      var day = today.getDate();
      this.date = year + '年' + month + '月' + day + '日';
    },
    trimName: function(langName){
      var name = langName.toLowerCase().replace(/\s+/g, '').replace('#', 's').replace('.', 'd');
      return name;
    }
  },
}
</script>

<style scoped>
.fas {
  color: gray;
  margin-left: 10px;
}
.fas:hover {
  color: black;
  transition-duration: 0.25s;
}
.rank__stock-title {
  color: gray;
  overflow: hidden;
  text-decoration: none;
  white-space: nowrap;
  width: 120px;
}
.rank__stock-title:hover {
  color: black;
}
</style>

