<template>
  <nav class="nav-head-bar" :class="this.separateColor()">
    <div class="nav-head-bar__container">
      <div class="nav-head-bar__title">
        <button @click="openNoticeSignal()"><a>{{ notification.title }}</a></button>
      </div>
    </div>
  </nav>
</template>

<script>
import axios from 'axios'
export default {
  data(){
    return {
      notification: {}
    }
  },
  mounted() {
    this.getNotification()
  },
  methods: {
    getNotification(){
      axios
        .get('/api/v1/notifications/show_below_header.json')
        .then(response => {
          this.notification = response.data
          if(response.data.length == 0){
            this.$emit("closeNotice")
          }
        })
        .catch(error => {
          console.log(error)
        })
    },
    openNoticeSignal(){
      this.$emit('openNoticeDetail', this.notification.id)
    },
    separateColor(){
      return this.notification.is_important ? "bg-danger" : ""
    }
  }
}
</script>

<style>

</style>
