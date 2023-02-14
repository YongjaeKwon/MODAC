import { useStatsStore } from '@/stores/statistics';
import { storeToRefs } from "pinia"

const statsStore = useStatsStore();
const { radarData } = storeToRefs(statsStore)


export const radarChartData = {
  type: "radar",
  data: {
    labels: [
      radarData.value[0].categoryName,
      radarData.value[1].categoryName,
      radarData.value[2].categoryName,
      radarData.value[3].categoryName,
      radarData.value[4].categoryName,
    ],
    datasets: [
      {
        label: "카테고리별 작성 횟수",
        data: [
          radarData.value[0].countArticles,
          radarData.value[1].countArticles,
          radarData.value[2].countArticles,
          radarData.value[3].countArticles,
          radarData.value[4].countArticles,
        ],
        fill: true,
        backgroundColor: "rgb(54, 162, 235, 0.2)",
        borderColor: "rgb(54, 162, 235)",
        borderWidth: 1,
        pointBackgroundColor: "rgb(54, 162, 235)",
        pointHoverBorderColor: "rgb(54, 162, 235)",
      }
    ]
  },
  options: {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
    },
    scale: {
      ticks: {
        // suggestedMin: 0,
        beginAtZero: true,
        stepSize:1
      }
    }
  },
};




export default radarChartData;