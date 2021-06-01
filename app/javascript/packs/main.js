import Vue from 'vue';
import App from '../App.vue';
import Vuetify from 'vuetify';
import router from './router';

Vue.use(Vuetify);

document.addEventListener('turbolinks:load', () => {
  const insertTarget = document.getElementById('body')
  const alreadyInsert = document.getElementById('app')
  if(alreadyInsert) {
    while(alreadyInsert.lastChild){
      alreadyInsert.removeChild(alreadyInsert.lastChild);
    }
  }
  if(document.URL.match("/users/")) return false;
  if(insertTarget) {
    const usr = new Vue({
      router,
      vuetify: new Vuetify(),
      render: h => h(App)
    }).$mount()
    insertTarget.insertAdjacentElement('afterbegin', usr.$el)
  }
})
