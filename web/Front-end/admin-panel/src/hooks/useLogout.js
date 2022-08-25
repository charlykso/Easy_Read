import {useAuthContext} from "./useAuthContext";
import { useNavigate } from 'react-router-dom'

export const useLogout = () => {
    const { dispatch } = useAuthContext()
    const navigate = useNavigate()
    const logout = () => {
        //remove toke from localstorage
        localStorage.removeItem('user')

        //dispatch logout function
        dispatch({type: 'LOGOUT'})

        navigate('/')
    }

    return {logout}
}