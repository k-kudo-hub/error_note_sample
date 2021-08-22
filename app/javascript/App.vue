<template>
  <div id="app" class="app">
    <Header
      @search="searchSignal"
      @newLog="newLogSignal"
      :currentUser="currentUser"
    />
    <NoticeBar 
      v-if="haveNotice"
      @closeNotice="closeNotice"
      @openNoticeDetail="openNoticeDetail"
    />
    <div class="app-body" id="app_body">
      <Loading v-if="this.loading" />
      <LogsCreate 
        v-if="currentUser.auth"
        :logSignal="logSignal"
        @closeLogSignal="closeLog"
      />
      <NotificationsShow
        v-if="notification_id != 0"
        @closeNoticeDetail="closeNoticeDetail"
        :notification_id="notification_id"
      />
      <router-view
        :catchKeyword="keyword"
        :currentUser="currentUser"
        @startLoad="startLoad"
        @endLoad="endLoad"
        @openNoticeDetail="openNoticeDetail"
      />
    </div>
    <Footer/>
  </div>
</template>
<script>
import axios from 'axios'
import Footer from 'components/shared/Footer.vue'
import Header from 'components/shared/Header.vue'
import Loading from 'components/shared/Loading.vue'
import LogsCreate from 'components/logs/Create.vue'
import LogsIndex from 'components/logs/Index.vue'
import NoticeBar from 'components/notifications/NavBar.vue'
import NotificationsShow from 'components/notifications/Show.vue'
import VueRouter from 'vue-router'
export default {
  components: {
    Footer,
    Header,
    Loading,
    LogsCreate,
    LogsIndex,
    NoticeBar,
    NotificationsShow,
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
      haveNotice: true,
      notification_id: 0,
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
    searchSignal(keyword){
      this.keyword = keyword;
    },
    newLogSignal(){
      this.logSignal = true;
    },
    closeLog(){
      this.logSignal = false;
    },
    closeNotice(){
      this.haveNotice = false;
    },
    closeNoticeDetail(){
      this.notification_id = 0;
    },
    startLoad(message){
      this.loading = true;
      if(message){console.log(message)}
    },
    endLoad(){
      this.loading = false;
    },
    openNoticeDetail(...args){
      this.notification_id = args[0]
    }
  }
}

</script>
<style scoped>

</style>
