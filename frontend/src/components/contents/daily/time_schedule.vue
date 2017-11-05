<template>
  <div class="row time_schedule">
    <div class="col-xs-12 col-sm-8">
      <table class="time-table table">
        <tr v-for="hour in hours">
          <td class="hour">{{ hour }} </td>
          <td v-for="minute in minutes" class="enter yet" :id="hour + ':' + minute" @click="select(hour, minute)">
            {{ minute | forDisplay }}-{{ minute + 15 | forDisplay }} <i class="fa fa-caret-down"></i>
          </td>
        </tr>
      </table>
    </div>
    <div class="col-xs-12 col-sm-4 enter-area">
      <h2>{{ selected }}</h2>
    </div>
  </div>
</template>

<script>
  import _ from 'underscore';

  export default {
    data: function() {
      return {
        hours: _.range(0, 24),
        minutes: [0, 15, 30, 45],
        selected: null
      }
    },
    filters: {
      forDisplay: function(minute) {
        if (minute == "0" || minute == "60") return "00";
        return minute;
      }
    },
    methods: {
      select: function(hour, minute) {
        const start = `${hour}:${this.$options.filters.forDisplay(minute)}`;
        const end = minute == '45' ? `${hour+1}:00` : `${hour}:${this.$options.filters.forDisplay(minute+15)}`;
        this.selected = `${start}-${end}`;
      }
    }
  };
</script>

<style lang="scss">
  .time_schedule {
    height: 100%;
    padding: 80px 0 30px 0;

    > div {
      height: 100%;
      padding: 0;
      overflow-y: auto;
    }

    .time-table {
      width: 100%;

      tr {
        td {
          padding: 5px;
          font-size: 13px;
          cursor: pointer;
        }

        td.hour {
          width: 4%;
          text-align: right;
        }

        td.enter {
          width: 24%;
          text-align: center;
        }

        td.yet {
          color: #CCC;
          border: 1px dotted #BBB;
        }
        td.complete {
          border: 1px solid #000;
        }
      }
    }

    .enter-area {
      padding: 0 15px;

      h2 {
        margin: 0;
      }
    }
  }
</style>
