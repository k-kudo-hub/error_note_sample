<template>
  <div id="log_modal">
  </div>
</template>
<script>
import axios from 'axios';
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

</script>
<style scoped>
.inner-bottom-btn-wrap {
  margin-top: 20px;
  text-align: center;
}
.log-modal__back {
  background-color: rgba(0,0,0, 0.4);
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 5;
}
.log-modal__container {
  background-color: white;
  padding: 32px;
  max-width: 800px;
  max-height: 87%;
  overflow: scroll;
  margin: 20px auto 30px;
  z-index: 6;
}
.log-modal__container h2 {
  text-align: center;
}
.log-modal__opener {
  height: 50px;
  width: 50px;
  position: fixed;
  right: 5%;
  bottom: 5%;
  z-index: 2;
  background-color: #509556;
  border-radius: 40px;
}
.log-modal__opener i {
  height: 20px;
  width: 20px;
  color: white;
  position: absolute;
  top: 35%;
  left: 32%;
}
</style>
