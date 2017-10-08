<template>
  <div>
    <nav>
      <div class="nav-wrapper">
        <a href="/app" class="brand-logo">fifteen</a>
        <ul class="right hide-on-med-and-down">
          <li>
            <router-link to="/settings">
              <i class="material-icons fa fa-cog fa-2x"></i>
            </router-link>
          </li>
          <li>
            <a href="/signout">
              <i class="material-icons fa fa-sign-out fa-2x"></i>
            </a>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>

<script>
  export default {}
</script>
