<template>
  <div>
    <div id="container" style="width: 100%;height: 100vh"></div>

    <div id="info"></div>
  </div>
</template>

<script>
// 信息窗体的内容
var content = [
  "<div style='font-size: 14px;color: red;width: 200px;height: 50px'>这是信息窗口</div>"
];

//获取用户所在城市信息
function showCityInfo() {
  //实例化城市查询类
  var citysearch = new AMap.CitySearch();
  //自动获取用户IP，返回当前城市
  citysearch.getLocalCity(function(status, result) {
    if (status === 'complete' && result.info === 'OK') {
      if (result && result.city && result.bounds) {
        var cityinfo = result.city;
        var citybounds = result.bounds;
        document.getElementById('info').innerHTML = '您当前所在城市：'+cityinfo;
        //地图显示当前城市
        map.setBounds(citybounds);
      }
    } else {
      document.getElementById('info').innerHTML = result.info;
    }
  });
}

export default {
  name: "Map",
  data() {
    return {}
  },
  created() {
  },
  mounted() {
    // 创建地图实例
    var map = new AMap.Map("container", {
      zoom: 13,
      center: [116.397966,39.919354],
      resizeEnable: true
    })
    // 创建一个 Marker 实例：
    var marker = new AMap.Marker({
      position: new AMap.LngLat(116.397966,39.919354),   // 经纬度对象，也可以是经纬度构成的一维数组[116.39, 39.9]
      title: '北京故宫',
      icon: '//vdata.amap.com/icons/b18/1/2.png'
    })
    // 将创建的点标记添加到已有的地图实例：
    map.add(marker)

    // 创建 infoWindow 实例
    var infoWindow = new AMap.InfoWindow({
      anchor: 'center',
      content: content.join("<br>")  //传入 dom 对象，或者 html 字符串
    });

    var clickHandler = function(e) {
      console.log('您在[ '+e.lnglat.getLng()+','+e.lnglat.getLat()+' ]的位置点击了地图！');

      infoWindow.open(map,map.getCenter());
    };
    // 绑定事件
    marker.on('click', clickHandler);

    //绘制初始路径
    var path = [];
    path.push([116.303843, 39.983412]);
    path.push([116.321354, 39.896436]);
    path.push([116.407012, 39.992093]);
    map.plugin("AMap.DragRoute", function() {
      var route = new AMap.DragRoute(map, path, AMap.DrivingPolicy.LEAST_FEE); //构造拖拽导航类
      route.search(); //查询导航路径并开启拖拽导航
    });
    var polyLine = new AMap.Polyline({
      path: path,
      strokeWeight: 5,
      borderWeight: 5, // 线条宽度，默认为 1
      strokeStyle: "solid",
      strokeColor: '#f30434', // 线条颜色
      lineJoin: 'round' // 折线拐点连接处样式
    })
    map.add(polyLine)

    showCityInfo();
  },
  methods: {}
}
</script>

<style scoped>

</style>