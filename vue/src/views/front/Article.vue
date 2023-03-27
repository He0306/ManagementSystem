<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:300px" suffix-icon="el-icon-search" placeholder="请输入文章标题" v-model="name"
                clearable size="small"></el-input>
      <el-button style="margin-left: 3px" type="primary" @click="load" size="small">搜索</el-button>
      <el-button style="margin-left: 3px" type="warning" @click="reset" size="small">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <div style="padding: 10px 0; border-bottom: 1px dashed #ccc" v-for="item in tableData" :key="item.id">
        <div class="pd-10" style="font-size: 20px;color: #1E90FF;cursor: pointer" @click="$router.push('/front/articleDetail?id=' + item.id)">{{ item.name }}</div>
        <div style="font-size: 14px;margin-top: 10px">
          <i class="el-icon-user-solid"><span>{{item.user}}</span></i>
          <i class="el-icon-time" style="margin-left: 10px"><span>{{item.time}}</span></i>
        </div>
      </div>
    </div>

    <div style="padding-left: 400px;padding-top: 15px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5,10,15,20]"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>


export default {
  name: "Article",
  data() {
    return {
      tableData: [],
      name: '',
      pageNum: 1,
      pageSize: 5,
      total: 0,
      headerBg: 'headerBg',
    }
  },
  created() {
    this.load()
  },
  methods: {

    //分页查询
    load() {
      this.request.get("/article/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data.records
        this.total = res.data.total
      });

    },
    //页数
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    //页码
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.load()
    },

    //搜索重置按钮
    reset() {
      this.name = ""
      this.load()
    },
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>