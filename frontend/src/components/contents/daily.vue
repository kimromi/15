<template>
  <div class="daily">
    <div class="daily-header">
      <h1>
        <router-link :to="beforeDate"><i class="fa fa-caret-left"></i></router-link>
        {{ date }} <span class="day">{{ day }}</span>
        <router-link :to="nextDate"><i class="fa fa-caret-right"></i></router-link>
      </h1>

      <percentage></percentage>
    </div>

    <time_schedule></time_schedule>
  </div>
</template>

<script>
  import { mapActions } from 'vuex'
  import TimeSchedule from './daily/time_schedule.vue';
  import Percentage from './daily/percentage.vue';
  import Date from '../../lib/date'

  export default {
    components: {
      percentage: Percentage,
      time_schedule: TimeSchedule
    },
    data: function() {
      return {
        date: null,
        day: null,
        beforeDate: null,
        nextDate: null,
      }
    },
    watch: {
      '$route': 'routeChanged'
    },
    created() {
      this.routeChanged();
    },
    methods: {
      ...mapActions([
        'changeDate'
      ]),
      routeChanged() {
        this.date = this.$route.params.date || Date.today();
        this.changeDate(this.date);
        this.day = Date.day(this.date);
        this.beforeDate = Date.beforeDay(this.date);
        this.nextDate = Date.nextDay(this.date);
      },
    }
  };
</script>

<style lang="scss">
  .daily {
    height: 100%;

    .daily-header {
      position: absolute;
      top: 0;
      left: 0;
      padding: 0 30px 0 230px;
      width: 100%;
      height: 100px;
    }

    h1 {
      .day {
        font-size: 60%;
        font-weight: normal;
      }

      a {
        color: gray;
        &:hover, &:active, &:focus {
          color: gray;
        }
      }
    }
  }
</style>
