<template>
  <div class="app-bottom-inner">
    <div class="bottom-profile__upper">
      <div class="profile-img__container">
        <img v-if="user.picture != null" :src="user.picture">
        <img v-else src="../../assets/images/human.png">
      </div>
      <div class="profile-introduce__container">
        <div class="profile-introduce__name">
          <h2>{{ user.name }}</h2>
        </div>
        <div class="profile-introduce__word">
          {{ user.introduce }}
        </div>
      </div>
    </div>
    <div class="bottom-profile__lower">
      <div class="profile-btn__container">
        <template v-if="use_case == 'log'">
          <a @click="showMoreUserInformations" class="btn-default"><i class="fas fa-external-link-alt"></i> プロフィールへ</a>
        </template>
        <template v-else>
          <template v-if="(currentUser.auth == true) && (currentUser.id == user.id)">
            <a href="/users/edit" class="btn-filled"><i class="fas fa-edit"></i> 編集する</a>
            <a href="/users/sign_out" data-method="delete" class="btn-default"><i class="fas fa-sign-out-alt"></i> ログアウト</a>
          </template>
        </template>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return {
      
    }
  },
  props: {
    user: {
      id: 0,
      name: "",
      picture: "",
      introduce: "",
    },
    currentUser: {
      id: null,
      picture: null,
      auth: false,
    },
    use_case: "",
  },
  methods: {
    showMoreUserInformations: function(){
      this.$router.push({
        name: 'users-show',
        params: {
          user_id: this.user.id 
        }
      })
    }
  }
}
</script>

<style lang="scss">

</style>
