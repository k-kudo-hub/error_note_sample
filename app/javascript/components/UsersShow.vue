<template>
  <div class="user-show">
    <LogsTable
      :logs="logs"
      :currentUser="currentUser"
      :currentPage="logsCurrentPage"
      :totalPages="logsTotalPages"
      :currentLogs="getUserLogs"
      :pageTitle="user.name + 'のノート'"
      @paginate="paginateLog"
      @showMoreInfo="showMoreInformations"
      @showMoreUserInfo="showMoreUserInformations"
    />
    <LogsTable
      v-if="currentUser.auth && (currentUser.id == user.id)"
      :logs="stocks"
      :currentUser="currentUser"
      :currentPage="stocksCurrentPage"
      :totalPages="stocksTotalPages"
      :currentLogs="getUserStocks"
      pageTitle='ストック一覧'
      @paginate="paginateStock"
      @showMoreInfo="showMoreInformations"
      @showMoreUserInfo="showMoreUserInformations"
     />
    <UsersProfile :user="user" :currentUser="currentUser" />
  </div>
</template>

<script>
import axios from 'axios';
import UsersProfile from '../components/UsersProfile';
import LogsTable from '../components/LogsTable';

export default {
  components: {
    'UsersProfile': UsersProfile,
    'LogsTable': LogsTable,
  },
  data(){
    return {
      user: {
        id: 0,
        name: "",
        introduce: "",
        picture: null,
      },
      logs: {

      },
      logsCurrentPage: 1,
      logsTotalPages: null,
      stocks: {

      },
      stocksCurrentPage: 1,
      stocksTotalPages: null,
      itemPerPage: 10,
    }
  },
  props: {
    currentUser: {
      id: null,
      picture: null,
      auth: false,
    }
  },
  mounted(){
    this.getUser();
    this.getUserLogs();
    this.getUserStocks();
  },
  methods: {
    getUser: function(){
      axios
        .get(`/api/v1/users/show.json?user_id=${this.$route.params['user_id']}`)
        .then(response => (
          this.user = response.data
        ))
    },
    getUserLogs: function(){
      axios
        .get(`/api/v1/users/user_log_index.json?user_id=${this.$route.params['user_id']}&page=${this.logsCurrentPage}`)
        .then(response => (
          this.logs = response.data.logs,
          this.logsTotalPages = response.data.total_pages
        ))
    },
    getUserStocks: function(){
      axios
        .get(`/api/v1/stocks/index.json?page=${this.stocksCurrentPage}`)
        .then(response => (
          this.stocks = response.data.stocks,
          this.stocksTotalPages = response.data.total_pages
        ))
    },
    paginateLog: async function(...args){
      this.logsCurrentPage = args[0]
      await this.getUserLogs();
    },
    paginateStock: function(...args){
      this.stocksCurrentPage = args[0]
      this.getUserStocks();
    },
    showMoreInformations: function(...args){
      this.$router.push({
        name: 'logs-show',
        params: {
          user_id: args[0],
          log_id: args[1], 
        }
      })
    },
    showMoreUserInformations: function(...args){
      location.href=`/users/${args}`
    },
  }
}
</script>

<style lang="scss" scoped>

</style>
