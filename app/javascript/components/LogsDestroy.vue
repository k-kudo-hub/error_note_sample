<template>
  <div id="log_modal">
    <div class="log-modal__back" @click.self="$emit('cancel')">
      <div class="log-modal__container-destroy">
        <h2>このノートを削除しますか？</h2>
        <p class="log-modal__sub-title">「{{ title }}」</p>
        <div class="inner-bottom-btn-wrap">
          <button @click="$emit('cancel')" type="submit" class="btn-default">
            <i class="fas fa-long-arrow-alt-left"></i> キャンセル
          </button>
          <button @click="$emit('submit')" type="submit" class="btn-danger">
            <i class="fas fa-trash-alt"></i> 削除する
          </button>
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
