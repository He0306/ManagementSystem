<template>
  <div style="padding: 10px">
    <el-card>
      <div v-for="item in video" :key="item.id" style="margin: 10px 0;color: #666;border-bottom: 1px dashed #ccc">
        <span style="font-size: 18px; cursor: pointer" class="item" @click="detail(item.id)">{{ item.name }}</span>
        <span style="float: right;font-size: 12px;margin-top: 10px">文件大小：{{ item.size }} KB </span>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "Video",
  data() {
    return {
      video: []
    }
  },
  created() {
    this.request.get('/file/front/all').then(res => {
      console.log(res.data)
      this.video = res.data.filter(v => v.type === 'mp4')
    })
  },
  methods: {
    detail(id) {
      this.$router.push({path: "/front/videoDetail", query: {id: id}})
    }
  }
}
</script>

<style scoped>
.item:hover {
  color: #1E90FF;
  background: none;
}
</style>