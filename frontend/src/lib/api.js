import axios from 'axios';

export default {
  currentTeam: function() {
    return axios.get('/api/v1/team');
  },
  teams: function() {
    return axios.get('/api/v1/teams');
  }
};
