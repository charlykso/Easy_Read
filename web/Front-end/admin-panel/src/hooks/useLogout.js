import {useAuthContext} from "./useAuthContext";
import { useNavigate } from 'react-router-dom'

export const useLogout = () => {
    const { dispatch } = useAuthContext()
    const navigate = useNavigate()
    const logout = () => {
        //remove token from localstorage
        localStorage.removeItem('user')
        localStorage.removeItem('token')

        //dispatch logout function
        dispatch({type: 'LOGOUT'})

        navigate('/login')
    }

    return {logout}
}