import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

import App from './components/app.vue';
import Reports from './components/contents/reports.vue';
import MyReports from './components/contents/reports/me.vue';
import TeamReports from './components/contents/reports/team.vue';

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
        { path: 'reports', component: Reports, children: [
          { path: '', redirect: 'me' },
          { path: 'me', component: MyReports, name: 'my reports' },
          { path: 'team', component: TeamReports, name: 'team reports' },
        ]},
        { path: 'tasks', component: Tasks },
        { path: 'team', component: Team },
        { path: 'members/me', component: Me },
        { path: '', redirect: '/daily' },
        { path: 'daily', component: Daily, children: [
          { path: '', redirect: Date.today() },
          { path: ':date', component: TimeSchedule, name: 'daily' },
        ]},
      ]
    }
  ]
});
export default router;

