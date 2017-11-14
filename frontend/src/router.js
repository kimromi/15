import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import App from './components/app.vue';
import Tasks from './components/contents/tasks.vue';
import Team from './components/contents/team.vue';
import Me from './components/contents/me.vue';

import Daily from './components/contents/daily.vue';
import TimeSchedule from './components/contents/daily/time_schedule.vue';

import Date from './lib/date';

const router = new VueRouter({
  routes: [
    {
      path: '/', component: App, children: [
        { path: 'tasks', component: Tasks },
        { path: 'team', component: Team },
        { path: 'members/me', component: Me },
        { path: 'daily', component: Daily, children: [
          { path: '', redirect: Date.today() },
          { path: ':date', component: TimeSchedule, name: 'daily' },
        ]},
      ]
    }
  ]
});
export default router;

