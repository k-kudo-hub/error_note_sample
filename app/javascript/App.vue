<template>
  <div id="app" class="app">
    <Header @search="searchSignal" :currentUser="currentUser"></Header>
    <div class="app-body" id="app_body">
      <LogsCreate v-if="currentUser.auth == true"></LogsCreate>
      <router-view :catchKeyword="keyword" :currentUser="currentUser"></router-view>
    </div>
    <Footer></Footer>
  </div>
</template>
<script>
import axios from 'axios'
import VueRouter from 'vue-router'
import LogsIndex from 'components/LogsIndex.vue'
import LogsCreate from 'components/LogsCreate.vue'
import Header from 'components/Header.vue'
import Footer from 'components/Footer.vue'

export default {
  components: {
    LogsIndex,
    LogsCreate,
    Header,
    Footer,
  },
  data(){
    return {
      currentUser: {
        id: null,
        picture: null,
        auth: false,
      },
      keyword: "",
    }
  },
  mounted() {
    var self = this;
    axios
      .get('/api/v1/users/authentication.json')
      .then(response => (self.currentUser = response.data))
  },
  methods: {
    searchSignal: function(keyword){
      this.keyword = keyword;
    }
  }
}

</script>
<style scoped>

</style>
