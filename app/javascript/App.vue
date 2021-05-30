<template>
  <div id="app" class="app">
    <Header :user="user"></Header>
    <div class="app-body" id="app_body">
      <LogsCreate  v-if="user.auth == true"></LogsCreate>
      <LogsIndex :user="user"></LogsIndex>
    </div>
    <Footer></Footer>
  </div>
</template>
<script>
import axios from 'axios'
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
      user: {
        id: null,
        picture: null,
        auth: false,
      }
    }
  },
  mounted() {
    var self = this;
    axios
      .get('/api/v1/users/authentication.json')
      .then(response => (self.user = response.data))
  }
}
</script>
<style scoped>

</style>
