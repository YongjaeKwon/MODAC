import axios from "axios";
import BACK_END_SERVER_URL from "./backend";

const instance = axios.create({
  baseURL: `${BACK_END_SERVER_URL}`,
  headers: {
    "Content-Type": "application/json", // 객체 형식의 데이터 body로 보낼때
    //'Content-Type': 'text/plain' // 일반 스트링만 body로 보낼때
  },
});

export default instance;
