<template>
  <div id="app" class="app">
    <Header
     @search="searchSignal"
     @newLog="newLogSignal"
     :currentUser="currentUser"
    />
    <div class="app-body" id="app_body">
      <Loading v-if="this.loading" />
      <LogsCreate 
        v-if="currentUser.auth"
        :logSignal="logSignal"
        @closeLogSignal="closeLog"
      />
      <router-view
        :catchKeyword="keyword"
        :currentUser="currentUser"
        @startLoad="startLoad"
        @endLoad="endLoad"
      />
    </div>
    <Footer/>
  </div>
</template>
<script>
import axios from 'axios'
import VueRouter from 'vue-router'
import LogsIndex from 'components/logs/Index.vue'
import LogsCreate from 'components/logs/Create.vue'
import Header from 'components/shared/Header.vue'
import Footer from 'components/shared/Footer.vue'
import Loading from 'components/shared/Loading.vue'
export default {
  components: {
    LogsIndex,
    LogsCreate,
    Header,
    Footer,
    Loading,
  },
  data(){
    return {
      currentUser: {
        id: null,
        picture: null,
        auth: false,
      },
      keyword: "",
      logSignal: false,
      loading: true,
    }
  },
  created() {
    var self = this;
    axios
      .get('/api/v1/users/authentication.json')
      .then(response => (self.currentUser = response.data))
  },
  mounted(){
    this.endLoad();
  },
  methods: {
    searchSignal: function(keyword){
      this.keyword = keyword;
    },
    newLogSignal: function(){
      this.logSignal = true;
    },
    closeLog: function(){
      this.logSignal = false;
    },
    startLoad: function(message){
      this.loading = true;
      if(message){console.log(message)}
    },
    endLoad: function(){
      this.loading = false;
    }
  }
}

</script>
<style scoped>

</style>
