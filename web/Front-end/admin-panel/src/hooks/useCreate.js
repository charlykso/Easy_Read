import { useState } from "react";

export const useCreate = () => {
    const [error, setError] = useState(null)
    const [isLoading, setIsLoading] = useState(null)
    const [resData, setResData] = useState(null)
    const [isCreated, setIsCreated] = useState(false)
    
    const createUser = async (url, formData, jwt) => {
      setIsLoading(true)
      setError(null)

      const response = await fetch(url, {
        method: 'post',
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
            setError('unauthorised')            
          } else {
            setError(data)
            console.log(data)
          }
        }
        else if (response.ok) {
          setIsLoading(false)
          setResData(data)
          setIsCreated(true)
        }
      } catch (error) {
        console.log(error.message);
        setError(error.message)
        
      }
    }

    return { createUser, isLoading, error, resData, isCreated, setIsCreated }
}