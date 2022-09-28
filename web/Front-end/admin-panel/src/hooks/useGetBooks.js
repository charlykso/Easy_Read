import { useState, useEffect } from 'react'

const useGetBooks = (url, jwt) => {
  const [data, setData] = useState(null)
  const [isPending, setIsPending] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    const abortCont = new AbortController()

    fetch(url, {
      method: 'GET',
      headers: { Authentication: 'Bearer ' + jwt },
    })
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
    return () => abortCont.abort()
  }, [url, jwt])

  return { data, isPending, error }
}

export default useGetBooks
