<template>
  <div id="log_modal">
    <div class="log-modal__back" @click.self="$emit('cancel')">
      <div class="log-modal__container-destroy">
        <h2>このノートを削除しますか？</h2>
        <p class="log-modal__sub-title">「{{ title }}」</p>
        <div class="inner-bottom-btn-wrap">
          <input @click="$emit('cancel')" type="submit" value="キャンセル" class="btn-default">
          <input @click="$emit('submit')" type="submit" value="削除する" class="btn-danger">
        </div>
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
    title: {type: String}
  }
}
</script>

<style lang="scss" scoped>

</style>
