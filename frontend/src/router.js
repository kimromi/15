import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import App from './components/app.vue';

const router = new VueRouter({
  routes: [
    { path: '/', component: App }
  ]
});
export default router;

