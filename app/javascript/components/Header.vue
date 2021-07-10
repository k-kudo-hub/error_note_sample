<template>
  <div class="header-area">
    <div class="header-container">
      <div class="header-left flex-3">
        <h1 @click="goHome">Error Note</h1>
      </div>
      <div class="header-center flex-3">
      </div>
      <div class="header-right flex-3">
        <div v-if="this.currentUser.auth">
          <form @submit.prevent @keypress.prevent.enter.exact="searchLogs" class="search-form">
            <span class="fa-stack">
              <input v-model="keyword" placeholder="キーワードを入力" class="fa-lg fa-stack-2x">
              <i class="fas fa-search fa-lg fa-stack-1x"></i>
            </span>
            <input type="hidden" value="検索">
          </form>
          <div class="header-btn-wrap">
            <a class="header-btn">
              <i @click="$emit('newLog')" class="fas fa-pen fa-lg"></i>
            </a>
            <a @click="showCurrentUserInformations" class="header-btn">
              <template v-if="this.currentUser.picture">
                <img :src="this.currentUser.picture" height="30px" width="30">
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
  props: {
    currentUser: {
      id: null,
      picture: null,
      auth: false,
    },
  },
  mouted(){

  },
  methods: {
    searchLogs: function(){
      if(location.pathname != "/"){
        this.goHome()
        setTimeout(()=>{
          this.$emit('search', this.keyword)
        }, 250)
      } else {
        this.$emit('search', this.keyword)
      }
    },
    goHome: function(){
      if(location.pathname != "/"){
        this.$router.push({
          name: 'logs-index'
        })
      }
    },
    showCurrentUserInformations: function(){
      this.$router.push({
        name: 'users-show',
        params: {
          user_id: this.currentUser.id, 
        }
      })
    }
  }

}
</script>
<style lang="scss" scoped>
.header-left {
  h1:hover{
    cursor: pointer;
  }
}
</style>
