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
  if(document.URL.match("/users/sign_in")) return false;
  if(document.URL.match("/users/sign_up")) return false;
  if(document.URL.match("/users/sign_out")) return false;
  if(document.URL.match("/users/password")) return false;
  if(document.URL.match("/users/password/new")) return false;
  if(document.URL.match("/users/password/edit")) return false;
  if(document.URL.match("/users/cancel")) return false;
  if(document.URL.match("/users/edit")) return false;
  if(document.URL.match("/logs/new")) return false;
  if(insertTarget) {
    const usr = new Vue({
      router,
      vuetify: new Vuetify(),
      render: h => h(App)
    }).$mount()
    insertTarget.insertAdjacentElement('afterbegin', usr.$el)
  }
})
