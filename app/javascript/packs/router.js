import Vue from 'vue';
import Router from 'vue-router';
import LogsIndex from '../components/LogsIndex.vue';
import LogsShow from '../components/LogsShow.vue';

Vue.use(Router);

export default new Router({
  mode: "history",
  routes: [
    { 
      path: '/', 
      component: LogsIndex,
      name: 'logs-index',
    },
    {
      path: '/users/:user_id/logs/:log_id',
      component: LogsShow,
      name: 'log-show',
    }
  ]
});
