// import Library from '../../images/OnlineLib.png'
import Library1 from '../../images/reader.png'
import Library_img from '../../images/library01.jpg'
import { Link } from 'react-router-dom'
import NewUsers from '../sub_pages/New_users'

function Home() {
  return (
    <div className='container mx-auto md:px-8 mb-5 mt-5'>
      <div className='relative libry'>
        <img className='h-[500px] w-full' src={Library_img} alt='Library' />
        <h1 className='absolute text-5xl text-white top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2'>
          Welcome!.
        </h1>
        <p className='absolute text-white top-1/2 left-[48%] -translate-x-[100px] -translate-y-[-25px]'>
          We take education to the next level.
        </p>
        <h3 className='absolute text-2xl text-blue-300 top-5 left-5'>
          <Link to='/'>Easyread</Link>
        </h3>
      </div>
      <div className='flex items-center justify-items-end max-h-full mt-5 mb-5'>
        <div className='flex justify-center w-3/5 max-h-[300px]'>
          <img className='h-[300px] w-[250px]' src={Library1} alt='Library' />
        </div>
        <NewUsers />
      </div>
    </div>
  )
}

export default Home
