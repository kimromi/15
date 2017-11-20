<template>
  <div class="time-schedule">
    <div class="percentage">
      <div class="progress">
        <div v-for="p in percentages" :key="p.task" class="progress-bar" :style="{ width: p.percentage + '%', 'background-color': p.color }" v-tooltip="tooltipContent(p)">
          {{ p.task }}
        </div>
      </div>
    </div>

    <div class="row time-table">
      <div class="table-area col-xs-12 col-sm-8">
        <table class="table">
          <tr v-for="hour in hours" :key="hour">
            <td class="hour">{{ hour }} </td>
            <td v-for="minute in minutes" :key="minute" class="enter" @click="select(hour, minute)" :class="cellClass(hour, minute)" :style="cellStyle(hour, minute)">
              <span v-if="records[hour + ':' + minute]">{{ records[hour + ':' + minute].task.name }}</span>
              <span v-else>{{ minute }}-{{ parseInt(minute) + 15 }}</span>
            </td>
          </tr>
        </table>
      </div>
      <div class="enter-area col-xs-12 col-sm-4">
        <ul class="list-group tasks">
          <li class="list-group-item task" v-for="task in tasks" :key="task.id" @click="record(task)">
            <div class="task-color" :style="{ 'background-color': task.background_color }">
              &nbsp;
            </div>
            {{ task.name }}
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex';
  import _ from 'underscore';
  import ApiClient from '../../../lib/api_client';

  export default {
    data: function() {
      return {
        hours: _.range(0, 24),
        minutes: ['00', '15', '30', '45'],
        records: {},
        selected: null,
        percentages: []
      };
    },
    computed: {
      ...mapGetters([
        'date',
        'tasks'
      ])
    },
    created: function() {
      this.dateChanged();
    },
    watch: {
      date: 'dateChanged',
      records: 'updateProgressBar'
    },
    methods: {
      dateChanged: async function() {
        await this.fetchRecords();
      },
      fetchRecords: async function() {
        const { records, error } = await ApiClient.records(this.date);
        if (!error) {
          for (const record of records) {
            this.records = Object.assign({}, this.records, { [record.time]: record });
          }
        } else {
          this.error = error.message;
        }
      },
      time: function(hour, minute) {
        return `${hour}:${minute}`;
      },
      select: function(hour, minute) {
        this.selected = this.time(hour, minute);
      },
      cellClass: function(hour, minute) {
        const time = this.time(hour, minute);
        return {
          active: this.selected == time,
          yet: !this.records[time],
          recorded: !!this.records[time]
        };
      },
      cellStyle: function(hour, minute) {
        const time = this.time(hour, minute);
        if (!this.records[time]) {
          return null;
        } else {
          return { 'background-color': this.records[time].task.background_color || '#FFF' };
        }
      },
      record: async function(task) {
        if (this.selected) {
          this.records = Object.assign({}, this.records, { [this.selected]: {task: {name: task.name, background_color: task.background_color}}});
          const { error } = await ApiClient.createRecord(this.date, this.selected, task.id);
          if (error) {
            this.error = error.message;
          }
        }
      },
      updateProgressBar: function() {
        const counts = {};
        const colors = {};
        let allCount = Object.keys(this.records).length;

        for (const key in this.records) {
          const task = this.records[key].task.name;
          counts[task] = counts[task] ? counts[task] + 1 : 1;
          colors[task] = this.records[key].task.background_color || '#FFF';
        }

        const percentages = [];
        for (const task in counts) {
          percentages.push({
            task: task,
            hour: Math.floor(counts[task] / 4),
            minute: (counts[task] % 4) * 15,
            percentage: (counts[task] / allCount) * 100,
            color: colors[task]
          });
        }
        this.percentages = percentages;
      },
      tooltipContent: function(percentage) {
        return `${percentage.percentage.toFixed(2)}% - ${percentage.hour}h${percentage.minute}m`;
      }
    }
  };
</script>

<style lang="scss">
  .time-schedule {
    height: 100%;
    padding: 110px 0 30px 0;

    .percentage {
      position: absolute;
      top: 70px;
      left: 0;
      padding: 0 30px 0 230px;
      width: 100%;

      .progress {
        height: 25px;
        border: 1px solid #EEE;

        .progress-bar {
          line-height: 23px;
          color: #000;
        }
      }
    }

    .time-table {
      height: 100%;

      .table-area {
        padding: 0;
        height: 100%;
        overflow-y: auto;

        table {
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
            td.active {
              color: #FFF;
              background-color: #333;
              border: 1px solid #333;
            }
            td.recorded {
              color: #000;
              border: 1px solid #CCC;
              font-weight: bold;
            }
          }
        }
      }
    }

    .enter-area {
      height: 100%;
      overflow-y: auto;

      h2 {
        margin: 0;
      }
    }

    .task {
      cursor: pointer;

      .task-color {
        display: inline-block;
        width: 23px;
        height: 23px;
        border: 1px solid #DEDEDE;
        margin-right: 3px;
      }
    }
  }

  .tooltip {
    display: block !important;
    z-index: 10000;

    .tooltip-inner {
      background: #1a1a1a;
      color: white;
      padding: 10px 20px;
      font-size: 18px;
    }

    .tooltip-arrow {
      width: 0;
      height: 0;
      border-style: solid;
      position: absolute;
      margin: 5px;
      border-color: #1a1a1a;
      z-index: 1;
    }

    &[x-placement^="top"] {
      margin-bottom: 5px;

      .tooltip-arrow {
        border-width: 5px 5px 0 5px;
        border-left-color: transparent !important;
        border-right-color: transparent !important;
        border-bottom-color: transparent !important;
        bottom: -5px;
        left: calc(50% - 5px);
        margin-top: 0;
        margin-bottom: 0;
      }
    }

    &[aria-hidden='true'] {
      visibility: hidden;
      opacity: 0;
      transition: opacity .15s, visibility .15s;
    }

    &[aria-hidden='false'] {
      visibility: visible;
      opacity: 1;
      transition: opacity .15s;
    }
  }
</style>
