<template>
  <div class="team">
    <h1>Team</h1>
    <h2>Members</h2>
    <ul class="list-group">
      <li class="list-group-item member" v-for="member in members" :key="member.id">
        <img :src="member.identity.image"/>
        {{ member.user.name }}
      </li>
    </ul>
    <div class="row invitation">
      <div class="col-xs-12 col-sm-2 text-center invitation__label">
        Invitation URL
      </div>
      <div class="col-xs-12 col-sm-10 invitation__url">
        <input type="text" :value="invitation.url" readonly onfocus="this.select();"/>
      </div>
    </div>
  </div>
</template>

<script>
  import ApiClient from '../../lib/api_client';

  export default {
    data: function() {
      return {
        members: [],
        invitation: {
          url: '',
        }
      };
    },
    mounted: function() {
      this.fetchMembers();
      this.fetchInvitation();
    },
    methods: {
      fetchMembers: async function() {
        const { members, error } = await ApiClient.members();
        if (!error) {
          this.members = members;
        } else {
          this.error = error.message;
        }
      },
      fetchInvitation: async function() {
        const { invitation, error } = await ApiClient.invitation();
        if (!error) {
          this.invitation = {
            url: `${location.protocol}//${location.host}/members/invitation/${invitation.token}`,
            expired: invitation.expired_at
          };
        } else {
          this.error = error.message;
        }
      }
    }
  };
</script>

<style lang="scss">
  .team {
    .member {
      img {
        width: 30px;
      }
    }

    .invitation {
      .invitation__label {
        padding-top: 10px;
        padding-bottom: 10px;
      }
      .invitation__url {
        input {
          width: 100%;
          padding: 10px 15px;
          border: none;
          background-color: #EEE;
          font-weight: bold;
        }
      }
    }
  }
</style>
