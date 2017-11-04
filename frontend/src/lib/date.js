import format from 'date-fns/format';
import addDays from 'date-fns/add_days';

export default {
  hyphenFormat: function(target) {
    return format(target, 'YYYY-MM-DD');
  },
  toDate: function(str) {
    return Date.parse(str);
  },
  day: function(str) {
    return format(this.toDate(str), 'ddd');
  },
  today: function() {
    return this.hyphenFormat(new Date());
  },
  beforeDay: function(str) {
    return this.hyphenFormat(addDays(this.toDate(str), -1));
  },
  nextDay: function(str) {
    return this.hyphenFormat(addDays(this.toDate(str), 1));
  }
};
