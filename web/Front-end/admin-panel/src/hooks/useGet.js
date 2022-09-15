import { useState, useEffect } from 'react'
import axios from 'axios'

const useGet = (url) => {
  const [data, setData] = useState(null)
  const [isPending, setIsPending] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    const getUsers = async () => {
       await axios
        .get(url)
        .then((res) => {
          if (!res.ok) {
            throw Error('could not fetch the data for the resource')
          }
          return res.json()
        })
        .then((data) => {
          setData(data)
          setIsPending(false)
          setError(null)
        })
        .catch((err) => {
          setIsPending(false)
          setError(err.message)
        })
    }
    getUsers()
  }, [url])

  return { data, isPending, error }
}

export default useGet
