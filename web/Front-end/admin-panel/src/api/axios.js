import axios from 'axios'

export default axios.create({
  baseURL: 'https://localhost:7144/api',
  // baseURL: 'https://reqres.in/api/',
})
