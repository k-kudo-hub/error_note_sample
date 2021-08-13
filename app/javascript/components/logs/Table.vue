<template>
  <section class="app-body-inner" :class="this.addClass">
    <h1 class="page-title">{{ pageTitle }}</h1>
    <v-list three-line v-if="this.logs.length > 0">
      <article v-for="(item) in logs" :key="item.id" class="log-block" :items-per-page="itemPerPage">
        <div class="log-block__upper">
          <h1 @click="$emit('showMoreInfo', item.user_id, item.id)">{{ item.title }}</h1>
        </div>
        <div class="log-block__lower">
          <div class="log-block__lower-languages">
            <template v-for="language in item.languages">
              <a class="lang" :class="trimName(language)" :key="language.name">{{ language }}</a>
            </template>
          </div>
          <div class="log-block__lower-user">
            <template v-if="item.user_picture">
              <img :src="item.user_picture" height="25px" width="25px">
            </template>
            <template v-else>
              <img src="../../../assets/images/human.png" height="25px" width="25px">
            </template>
            <div class="log-block__text-container">
              <template v-if="item.release">
                <p class="mr-5"><a @click="$emit('showMoreUserInfo', item.user_id)">{{ item.user_name }}</a></p>
                <p>が{{ item.updated_at }}に公開</p>
              </template>
              <template v-else>  
                <p> 非公開（{{ item.updated_at }}作成）</p>
              </template>
            </div>
          </div>
        </div>
      </article>
      <template v-if="this.totalPages > 1">
        <v-pagination
          v-model="localCurrentPage"
          :length="totalPages"
          :total-visible="7"
          color="#80c683"
          prev-icon="mdi-menu-left"
          next-icon="mdi-menu-right"
          circle
        />
      </template>
    </v-list>
    <p class="no-content-message" v-else>{{ pageTitle }}はありません。</p>
  </section>
</template>

<script>
import Vuetify from 'vuetify';

export default {
  data(){
    return {
      itemPerPage: 10
    }
  },
  props: {
    logs: {

    },
    currentPage: null,
    totalPages: 0,
    pageTitle: "",
    currentLogs: null,
    addClass: "",
  },
  computed: {
    localCurrentPage: {
      get: function(){
        return this.currentPage
      },
      set: function(value) {
        this.$emit('paginate', value)
      },
    },
  },
  methods: {
    trimName: function(langName){
      var name = langName.toLowerCase().replace(/\s+/g, '').replace('#', 's').replace('.', 'd').replace('++', 'pp');
      return name;
    },
  },
}
</script>

<style lang="scss" scoped>

</style>
