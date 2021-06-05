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
.inner-bottom-btn-wrap {
  margin-top: 20px;
  text-align: center;
}
.log-modal {
  &__back {
    background-color: rgba(0,0,0, 0.4);
    width: 100%;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 5;
  }
  &__container-destroy {
    background-color: white;
    padding: 32px;
    max-width: 600px;
    max-height: 60%;
    margin: 70px auto 30px;
    z-index: 6;
    h2 {
      text-align: center;
    }
  }
  &__sub-title {
    color: gray;
    margin-top: 50px;
    text-align: center;
  }
}
</style>
