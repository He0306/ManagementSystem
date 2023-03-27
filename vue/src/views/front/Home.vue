<template>
  <div>
    <div style="margin: 10px 0">
      <el-carousel height="430px" :interval="10000" >
        <el-carousel-item v-for="item in imgs" :key="item">
          <img :src="item" alt="" style="width: 100%;height: 100%">
        </el-carousel-item>
      </el-carousel>
    </div>

    <div style="margin: 10px 0">
      <el-row :gutter="10">
        <el-col :span="6" v-for="item in filter" :key="item.id" style="margin-bottom: 10px">

          <div style="border: 1px solid #ccc;padding-bottom: 10px">
          <img :src="item.url" alt="" style="width: 100%;height: 100%">
          <div style="color: #666;padding: 10px">{{item.name}}</div>
            <div style="padding: 10px"><el-button type="primary">购买</el-button></div>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
export default {
  name: "FrontHome",
  data(){
    return {
        imgs: [
          'https://imgcps.jd.com/ling4/100014352525/5Lqs6YCJ5aW96LSn/5L2g5YC85b6X5oul5pyJ/p-5bd8253082acdd181d02fa2e/e894c2fd/cr/s/q.jpg',
          'https://imgcps.jd.com/ling4/100014352543/5Lqs6YCJ5aW96LSn/5L2g5YC85b6X5oul5pyJ/p-5bd8253082acdd181d02fa06/b76934c1/cr/s/q.jpg',
            'https://img10.360buyimg.com/pop/s1180x940_jfs/t1/130131/8/27704/39513/625662e1E4ab76def/f53b3ab9a0d95f7b.jpg.webp'
        ],
      filter: []
    }
  },
  created() {
      this.request.get("/file/front/all").then(res=>{
       this.filter = res.data.filter(v => v.type === 'png' || v.type === 'jpg' || v.type === 'webp')
      })
  },
  methods: {

  }
}
</script>

<style scoped>

</style>