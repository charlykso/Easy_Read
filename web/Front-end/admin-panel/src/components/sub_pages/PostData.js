import { useState } from "react";
import axios from 'axios'

const PostData = async (durl, jwt, formdata) => {
  const [data, setData] = useState(null)
  const [isPending, setIsPending] = useState(true)
  const [error, setError] = useState(null)

  let headersList = {
    Authorization: 'Bearer ' + jwt,
  }
  let reqOptions = {
    url: durl,
    method: 'POST',
    headers: headersList,
    data: formdata,
  }
  await axios
    .request(reqOptions)
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
  return { data, isPending, error }

}

export default PostData
