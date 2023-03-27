<template>
  <div>
    <div style="padding: 10px 0">
      <el-input style="width:250px" suffix-icon="el-icon-search" placeholder="请输入文件名称" v-model="name"
                clearable></el-input>
      <el-button style="margin-left: 3px" type="primary" @click="load">搜索</el-button>
      <el-button style="margin-left: 3px" type="warning" @click="reset">重置</el-button>
    </div>
    <div style="margin: 5px 0">
      <el-upload action="http://127.0.0.1:8181/file/upload" :show-file-list="false" :on-success="handleFileUploadSuccess" style="display: inline-block">
        <el-button type="primary" style="margin-left: 5px">上传文件<i class="el-icon-top"></i></el-button>
      </el-upload>
      <el-popconfirm style="margin-left: 5px"
                     confirm-button-text='确定'
                     cancel-button-text='取消'
                     icon="el-icon-info"
                     icon-color="red"
                     title="您确定删除吗？"
                     @confirm="deleteBatch"
      >
        <el-button type="danger" slot="reference">批量删除<i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
    </div>
    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"/>
      <el-table-column prop="id" label="ID" width="80">
      </el-table-column>
      <el-table-column prop="name" label="文件名称" >
      </el-table-column>
      <el-table-column prop="type" label="文件类型" >
      </el-table-column>
      <el-table-column prop="size" label="文件大小(KB)" >
      </el-table-column>
      <el-table-column label="下载">
        <template slot-scope="scope">
          <el-button type="primary" @click="download(scope.row.url)">下载</el-button>
        </template>
      </el-table-column>
      <el-table-column label="是否启用">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.enable" active-color="#13ce66" inactive-color="#ccc" @change="changeEnable(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="200">
        <template slot-scope="scope">
          <el-popconfirm style="margin-left: 5px"
                         confirm-button-text='确定'
                         cancel-button-text='取消'
                         icon="el-icon-info"
                         icon-color="red"
                         title="您确定删除吗？"
                         @confirm="handleDelete(scope.row.id)"
          >
            <el-button type="danger" size="small" slot="reference">删除<i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding-left: 400px;padding-top: 15px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5,10,15,20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import {serverIp} from "../../public/config";

export default {
  name: "File",
  data() {
    return{
      serverIp: serverIp,
      tableData: [],
      name: '',
      multipleSelection: '',
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
      this.request.get("/file/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
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
    //根据ID删除
    handleDelete(id) {
      this.request.delete("/file/delete/" + id).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "删除成功",
            duration: 1 * 1000
          })
          this.load()
        } else {
          this.$message({
            type: "error",
            message: "删除失败",
            duration: 1 * 1000
          })
        }
      })
    },
    //批量删除 val:数组
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    deleteBatch() {
      let ids = this.multipleSelection.map(v => v.id)
      this.request.post("/file/delete/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message({
            type: "success",
            message: "批量删除成功",
            duration: 1 * 1000
          })
          this.load()
        } else {
          this.$message({
            type: "error",
            message: "批量删除失败",
            duration: 1 * 1000
          })
        }
      })
    },
    //上传文件
    handleFileUploadSuccess(res){
      if (res){
        this.$message({
          message: "上传文件成功",
          type: "success",
          duration: 1*1000
        })
        this.load()
      }else {
        this.$message({
          type: "error",
          message: "上传文件失败",
          duration: 1 * 1000
        })
      }

    },
    //文件下载
    download(url){
      window.open(url)
    },
    //是否启用
    changeEnable(row){
      this.request.post("/file/update",row).then(res=>{
        if (res.code === '200'){
          this.$message({
            message: "操作成功",
            type: "success",
            duration: 1*1000
          })
        }
      })
    },
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>