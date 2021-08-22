<template>
  <div class="modal__back" v-on:click.self="closeNoticeDetail">
    <div class="modal__container">
      <h2 class="modal-notice__title">{{ notification.title }}</h2>
      <p class="modal-notice__updated">{{ notification.updated_at }}</p>
      <p class="modal-notice__content">{{ notification.content }}</p>
      <div class="inner-bottom-btn-wrap">
        <button @click="closeNoticeDetail" type="submit" class="btn-default">
          <i class="fas fa-long-arrow-alt-left"></i> 閉じる
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import dateFormat from '../../date-format.js'
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
        .then(response => {
          this.notification = response.data
          this.notification.updated_at = dateFormat.short(this.notification.updated_at)
        })
        .catch(error =>{
          console.log(error)
        })
    },
  }
}
</script>

<style>

</style>
