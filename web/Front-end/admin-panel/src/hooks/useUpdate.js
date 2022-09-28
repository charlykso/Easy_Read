import { useState } from 'react'

export const useUpdate = () => {
  const [UpdateError, setUpdateError] = useState(null)
  const [isLoading, setIsLoading] = useState(null)
  const [responseData, setResponseData] = useState(null)

  const updateUser = async (url, formData, jwt, Id) => {
    setIsLoading(true)
    setUpdateError(null)

    const response = await fetch(url + Id, {
      method: 'put',
      headers: {
        Authorization: 'Bearer ' + jwt,
      },
      body: formData,
    })
    try {
      const data = await response.text()
      if (!response.ok) {
        setIsLoading(false)
        if (response.status === 401) {
          setUpdateError('unauthorised')
        } else {
          setUpdateError(data)
        }
      } else if (response.ok) {
        setIsLoading(false)
        setResponseData(data)
      }
    } catch (error) {
      setUpdateError(error.message)
    }
  }

  return { updateUser, isLoading, UpdateError, responseData }
}
