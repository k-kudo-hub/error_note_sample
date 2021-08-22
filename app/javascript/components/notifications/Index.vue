<template>
  <div class="nav-side-bar__notifications">
    <h2>お知らせ</h2>
    <div v-if="notifications.length > 0" class="nav-side-bar__notifications-container">
      <div v-for="item in notifications" :key="item.id" class="nav-side-bar__notifications-box">
        <div class="nav-side-bar__notifications-box__upper">
          <p>{{ formatShort(item.updated_at) }}</p>
        </div>
        <div class="nav-side-bar__notifications-box__lower">
          <button @click="openNoticeDetail(item.id)">{{ item.title }}</button>
        </div>
      </div>
    </div>
    <div v-else class="nav-side-bar__notifications-container">
      <p class="empty-notice-message">お知らせはありません。</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import format from '../../date-format'
export default {
  data(){
    return {
      notifications: [
        {
          id: 0,
          title: "",
          updated_at: "",
        }
      ]
    }
  },
  mounted(){
    this.getNoticeIndex();
  },
  methods: {
    getNoticeIndex(){
      axios
        .get('/api/v1/notifications/index.json')
        .then(response => {
          this.notifications = response.data
        })
        .catch(error => (console.log(error)))
    },
    formatShort(date){
      var formattedDate = date != "" ? format.short(date) : false
      return formattedDate
    },
    openNoticeDetail(id){
      this.$emit("openNoticeDetail", id)
    }
  }
}
</script>

<style>

</style>
