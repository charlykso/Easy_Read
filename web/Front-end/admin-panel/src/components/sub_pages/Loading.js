const Loading = () => {
    return (
      <div className='absolute flex justify-center items-center min-h-full mt-5 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 '>
        <div
          className='spinner-grow inline-block w-12 h-12 bg-current rounded-full '
          role='status'
        >
          <span className='visually-hidden'>
            Loading...
          </span>
        </div>
      </div>
    )
}
 
export default Loading;