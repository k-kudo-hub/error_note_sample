<template>
  <div class="log-modal__back" v-on:click.self="closeNoticeDetail">
    <div class="log-modal__container">
      <div class="modal__title-wrap">
        <h2>{{ notification.title }}</h2>
      </div>
      <div class="modal__updated-wrap">
        <p>{{ notification.updated_at }}</p>
      </div>
      <div class="modal__content-wrap">
        <p>{{ notification.content }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data(){
    return {
      notification: {

      }
    }
  },
  props: {
    notification_id: Number,
  },
  mounted(){
    this.getNoticeDetail()
  },
  methods: {
    closeNoticeDetail(){
      this.$emit("closeNoticeDetail")
    },
    getNoticeDetail(){
      axios
        .get(`/api/v1/notifications/show.json?id=${this.notification_id}`)
        .then(response => (this.notification = response.data))
        .catch(error =>{
          console.log(error)
        })
    }
  }
}
</script>

<style>

</style>
