<template>
  <div class="header-area">
    <div class="header-container">
      <div class="header-left flex-3">
        <h1><a href="/">Error Note</a></h1>
      </div>
      <div class="header-center flex-3">
      </div>
      <div class="header-right flex-3">
        <div v-if="this.user.auth == true">
          <form @submit.prevent @keypress.prevent.enter.exact="searchLogs" class="search-form">
            <span class="fa-stack">
              <input v-model="keyword" placeholder="キーワードを入力" class="fa-lg fa-stack-2x">
              <i class="fas fa-search fa-lg fa-stack-1x"></i>
            </span>
            <input type="hidden" value="検索">
          </form>
          <div class="header-btn-wrap">
            <a :href="'/users/'+ user.id +'/logs/new'" class="header-btn">
              <i class="fas fa-pen fa-lg"></i>
            </a>
            <a :href="'/users/'+ user.id" class="header-btn">
              <template v-if="this.user.picture">
                <img :src="this.user.picture" height="30px" width="30">
              </template>
              <template v-else>
                <img src="../../assets/images/human.png" height="30px" width="30px">
              </template>
            </a>
          </div>
        </div>
        <div v-else>
          <div class="header-btn-wrap">
            <a href='/users/sign_in' class="header-btn">
              <i id="sign_in_btn" class="fas fa-sign-in-alt fa-lg"></i>
            </a>
            <a href='/users/sign_up' class="header-btn">
              <i class="fas fa-user-plus fa-lg"></i>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template> 

<script>
import axios from 'axios';
export default {
  data(){
    return {
      keyword: "",
    }
  },
  props: ["user"],
  mouted(){

  },
  methods: {
    searchLogs: function(){
      this.$emit('search', this.keyword)
    }
  }

}
</script>
<style scoped>

</style>
