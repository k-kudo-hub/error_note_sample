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
  if( document.URL.match("/cancel")
   || document.URL.match("/users/edit")
   || document.URL.match("/logs/new")
   || document.URL.match("/users/confirmation")
   || document.URL.match("^.*users$")
   || document.URL.match("^.*logs$")
   || document.URL.match("^.*terms$")
   || document.URL.match("^.*privacy$")
   || document.URL.match("^(?=.*password).*$") 
   || document.URL.match("^(?=.*sign_).*$")
  ) return false;
  if(insertTarget) {
    const usr = new Vue({
      router,
      vuetify: new Vuetify(),
      render: h => h(App)
    }).$mount()
    insertTarget.insertAdjacentElement('afterbegin', usr.$el)
  }
})
